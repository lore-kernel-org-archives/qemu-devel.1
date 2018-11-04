Received: from eggs.gnu.org ([2001:4830:134:3::10]:40965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1gJMqE-000789-1q
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 13:09:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1gJMq8-0004an-C9
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 13:09:40 -0500
From: Leonid Bloch <lbloch@janustech.com>
Date: Sun, 4 Nov 2018 18:09:26 +0000
Message-ID: <20181104180900.7527-1-lbloch@janustech.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v2 0/1] vdi: Use a literal number of bytes for
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Stefan Weil <sw@weilnetz.de>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Leonid Bloch <lbloch@janustech.com>

Please see the commit message for the rationale.

Difference from v1:
* Format string is fixed.

Leonid Bloch (1):
  vdi: Use a literal number of bytes for DEFAULT_CLUSTER_SIZE

 block/vdi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--=20
2.17.1
