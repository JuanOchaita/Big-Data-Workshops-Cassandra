import csv, sys
src, out = sys.argv[1], sys.argv[2]
rd = lambda f: list(csv.DictReader(open(f"{src}/{f}", encoding="utf-8")))
servidores = {r["servidor_id"]: r for r in rd("servidores.csv")}
canales    = {r["canal_id"]: r for r in rd("canales.csv")}
usuarios   = {r["usuario_id"]: r for r in rd("usuarios.csv")}
mensajes   = rd("mensajes.csv")

def w(name, header, rows):
    with open(f"{out}/{name}.csv", "w", newline="", encoding="utf-8") as f:
        c = csv.writer(f); c.writerow(header); c.writerows(rows)

w("usuarios_por_id", ["usuario_id","nombre_usuario","creado_en"],
  [[u["usuario_id"], u["nombre_usuario"], u["creado_en"]+"+0000"] for u in usuarios.values()])
w("mensajes_por_canal", ["canal_id","enviado_en","mensaje_id","usuario_id","nombre_usuario","contenido"],
  [[m["canal_id"], m["enviado_en"]+"+0000", m["mensaje_id"], m["usuario_id"],
    usuarios[m["usuario_id"]]["nombre_usuario"], m["contenido"]] for m in mensajes])
w("mensajes_por_usuario", ["usuario_id","enviado_en","mensaje_id","canal_id","servidor","canal","contenido"],
  [[m["usuario_id"], m["enviado_en"]+"+0000", m["mensaje_id"], m["canal_id"],
    servidores[canales[m["canal_id"]]["servidor_id"]]["nombre"],
    canales[m["canal_id"]]["nombre"], m["contenido"]] for m in mensajes])
w("mensajes_por_canal_dia", ["canal_id","dia","mensaje_id"],
  [[m["canal_id"], m["enviado_en"][:10], m["mensaje_id"]] for m in mensajes])
