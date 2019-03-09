Received: from eggs.gnu.org ([209.51.188.92]:59764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1h2QI7-00075P-6K
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 19:56:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1h2QI6-000258-86
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 19:56:43 -0500
Resent-Message-Id: <E1h2QI6-000258-86@eggs.gnu.org>
Message-ID: <155209298740.8146.7385134403227050710@6acff2cf482b>
In-Reply-To: <20190307172401.29451-1-armbru@redhat.com>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Fri, 8 Mar 2019 16:56:29 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH v2 00/12] pc: Support firmware
 configuration with -blockdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: armbru@redhat.com
Cc: fam@euphon.net, qemu-devel@nongnu.org, kwolf@redhat.com, pkrempa@redhat.com, qemu-block@nongnu.org, mst@redhat.com, philmd@redhat.com, mreitz@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com, lersek@redhat.com

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDMwNzE3MjQwMS4yOTQ1
MS0xLWFybWJydUByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9j
a2VyLW1pbmd3QGZlZG9yYSBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21t
YW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVk
LCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBU
IEJFR0lOID09PQojIS9iaW4vYmFzaAp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtbWluZ3dAZmVkb3Jh
IFNIT1dfRU5WPTEgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgQ0Mg
ICAgICBody9jaGFyL25yZjUxX3VhcnQubwogIENDICAgICAgaHcvY2hhci9wYXJhbGxlbC5vCi90
bXAvcWVtdS10ZXN0L3NyYy9ody9ibG9jay9wZmxhc2hfY2ZpMDIuYzogSW4gZnVuY3Rpb24gJ3Bm
bGFzaF9jZmkwMl91bnJlYWxpemUnOgovdG1wL3FlbXUtdGVzdC9zcmMvaHcvYmxvY2svcGZsYXNo
X2NmaTAyLmM6Njk4OjU6IGVycm9yOiB1bmtub3duIHR5cGUgbmFtZSAncGZsYXNoX3QnOyBkaWQg
eW91IG1lYW4gJ2Zwb3NfdCc/CiAgICAgcGZsYXNoX3QgKnBmbCA9IENGSV9QRkxBU0gwMihkZXYp
OwogICAgIF5+fn5+fn5+CiAgICAgZnBvc190Ci90bXAvcWVtdS10ZXN0L3NyYy9ody9ibG9jay9w
Zmxhc2hfY2ZpMDIuYzo2OTg6MjE6IGVycm9yOiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5j
dGlvbiAnQ0ZJX1BGTEFTSDAyJzsgZGlkIHlvdSBtZWFuICdIV19GTEFTSF9IJz8gWy1XZXJyb3I9
aW1wbGljaXQtZnVuY3Rpb24tZGVjbGFyYXRpb25dCiAgICAgcGZsYXNoX3QgKnBmbCA9IENGSV9Q
RkxBU0gwMihkZXYpOwogICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn4KICAgICAgICAg
ICAgICAgICAgICAgSFdfRkxBU0hfSAovdG1wL3FlbXUtdGVzdC9zcmMvaHcvYmxvY2svcGZsYXNo
X2NmaTAyLmM6Njk4OjIxOiBlcnJvcjogbmVzdGVkIGV4dGVybiBkZWNsYXJhdGlvbiBvZiAnQ0ZJ
X1BGTEFTSDAyJyBbLVdlcnJvcj1uZXN0ZWQtZXh0ZXJuc10KL3RtcC9xZW11LXRlc3Qvc3JjL2h3
L2Jsb2NrL3BmbGFzaF9jZmkwMi5jOjY5ODoyMTogZXJyb3I6IGluaXRpYWxpemF0aW9uIG9mICdp
bnQgKicgZnJvbSAnaW50JyBtYWtlcyBwb2ludGVyIGZyb20gaW50ZWdlciB3aXRob3V0IGEgY2Fz
dCBbLVdlcnJvcj1pbnQtY29udmVyc2lvbl0KL3RtcC9xZW11LXRlc3Qvc3JjL2h3L2Jsb2NrL3Bm
bGFzaF9jZmkwMi5jOjY5OToxOTogZXJyb3I6IHJlcXVlc3QgZm9yIG1lbWJlciAndGltZXInIGlu
IHNvbWV0aGluZyBub3QgYSBzdHJ1Y3R1cmUgb3IgdW5pb24KICAgICB0aW1lcl9kZWwoJnBmbC0+
dGltZXIpOwogICAgICAgICAgICAgICAgICAgXn4KY2MxOiBhbGwgd2FybmluZ3MgYmVpbmcgdHJl
YXRlZCBhcyBlcnJvcnMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRj
aGV3Lm9yZy9sb2dzLzIwMTkwMzA3MTcyNDAxLjI5NDUxLTEtYXJtYnJ1QHJlZGhhdC5jb20vdGVz
dGluZy5kb2NrZXItbWluZ3dAZmVkb3JhLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0
ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNl
IHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=
