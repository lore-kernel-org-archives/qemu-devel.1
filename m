Received: from eggs.gnu.org ([2001:4830:134:3::10]:40597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1gJMoF-0004P4-4I
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 13:07:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1gJMoA-0002Pr-8p
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 13:07:38 -0500
From: Leonid Bloch <lbloch@janustech.com>
Date: Sun, 4 Nov 2018 18:07:25 +0000
Message-ID: <20181104180657.7471-1-lbloch@janustech.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v2 0/1] include: Add a comment to explain the
 origin of
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>, Markus Armbruster <armbru@redhat.com>, Leonid Bloch <lbloch@janustech.com>

Please see the commit message for the rationale.

Difference from v1:
* Tabs removed from the code indentation of the sample code in the
  comment, in order to pass checkpatch.

Leonid Bloch (1):
  include: Add a comment to explain the origin of sizes' lookup table

 include/qemu/units.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

--=20
2.17.1
