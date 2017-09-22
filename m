Received: from eggs.gnu.org ([2001:4830:134:3::10]:40347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dvPAa-0000zw-Ne
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 10:43:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dvPAX-0003KO-Kw
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 10:43:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37328)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dvPAX-0003Jl-EX
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 10:43:05 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 22 Sep 2017 11:42:57 -0300
Message-Id: <20170922144259.5956-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/2] Python next patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>

The following changes since commit 9ee660e7c138595224b65ddc1c5712549f0a27=
8c:

  Merge remote-tracking branch 'remotes/yongbok/tags/mips-20170921' into =
staging (2017-09-21 14:40:32 +0100)

are available in the git repository at:

  git://github.com/ehabkost/qemu.git tags/python-next-pull-request

for you to fetch changes up to ad904f6689f1ced282b413cb904c166f294a73ee:

  MAINTAINERS: Add Python scripts (2017-09-22 11:39:55 -0300)

----------------------------------------------------------------
Python queue, 2017-09-22

* MAINTAINERS update
* Fix logging issue on test scripts using qemu.py

----------------------------------------------------------------

Eduardo Habkost (2):
  qemu.py: Call logging.basicConfig() automatically
  MAINTAINERS: Add Python scripts

 scripts/qemu.py | 3 +++
 MAINTAINERS     | 8 ++++++++
 2 files changed, 11 insertions(+)

--=20
2.13.5
