Received: from eggs.gnu.org ([209.51.188.92]:42996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gidgS-0006Kb-1l
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 06:12:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gidgR-0007V9-6w
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 06:12:04 -0500
Resent-Message-Id: <E1gidgR-0007V9-6w@eggs.gnu.org>
Message-ID: <154737786915.37.4929087063074509285@2d170d368aaa>
Reply-To: <qemu-devel@nongnu.org>
In-Reply-To: <154713023826.379171.4010754027183178230.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Sun, 13 Jan 2019 03:11:10 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH] target/ppc/kvm: Drop useless include
 directive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: groug@kaod.org
Cc: fam@euphon.net, david@gibson.dropbear.id.au, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTQ3MTMwMjM4MjYuMzc5MTcx
LjQwMTA3NTQwMjcxODMxNzgyMzAuc3RnaXRAYmFoaWEubGFuLwoKCgpIaSwKClRoaXMgc2VyaWVz
IHNlZW1zIHRvIGhhdmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVs
b3cgZm9yCm1vcmUgaW5mb3JtYXRpb246CgpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIXSB0
YXJnZXQvcHBjL2t2bTogRHJvcCB1c2VsZXNzIGluY2x1ZGUgZGlyZWN0aXZlClR5cGU6IHNlcmll
cwpNZXNzYWdlLWlkOiAxNTQ3MTMwMjM4MjYuMzc5MTcxLjQwMTA3NTQwMjcxODMxNzgyMzAuc3Rn
aXRAYmFoaWEubGFuCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCBj
b25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYu
cmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0K
Li9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayAtLWNvbG9yPWFsd2F5cyBiYXNlLi4K
PT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFk
ZWY3ZjQ0YmQ4ODg3MTMzODQKVHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOgogIEZp
bGUgInBhdGNoZXctdGVzdGVyOC9zcmMvcGF0Y2hldy1jbGkiLCBsaW5lIDUyMSwgaW4gdGVzdF9v
bmUKICAgIGdpdF9jbG9uZV9yZXBvKGNsb25lLCByWyJyZXBvIl0sIHJbImhlYWQiXSwgbG9nZiwg
VHJ1ZSkKICBGaWxlICJwYXRjaGV3LXRlc3Rlcjgvc3JjL3BhdGNoZXctY2xpIiwgbGluZSA0OCwg
aW4gZ2l0X2Nsb25lX3JlcG8KICAgIHN0ZG91dD1sb2dmLCBzdGRlcnI9bG9nZikKICBGaWxlICIv
dXNyL2xpYjY0L3B5dGhvbjMuMy9zdWJwcm9jZXNzLnB5IiwgbGluZSA1NDQsIGluIGNoZWNrX2Nh
bGwKICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3Mu
Q2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdbJ2dpdCcsICdyZW1vdGUnLCAnYWRkJywgJy1m
JywgJy0tbWlycm9yPWZldGNoJywgJzNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3
MTMzODQnLCAnaHR0cHM6Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9xZW11J10nIHJldHVy
bmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIC05CgoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUg
YXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMTU0NzEzMDIzODI2LjM3OTE3MS40MDEwNzU0MDI3
MTgzMTc4MjMwLnN0Z2l0QGJhaGlhLmxhbi90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2Fn
ZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHA6Ly9w
YXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxA
cmVkaGF0LmNvbQ==
