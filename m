Received: from eggs.gnu.org ([209.51.188.92]:49893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1gwINA-0000dt-Fh
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 22:16:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1gwIN8-0003BH-JZ
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 22:16:36 -0500
From: Wei Yang <richardw.yang@linux.intel.com>
Date: Wed, 20 Feb 2019 11:15:55 +0800
Message-Id: <20190220031557.26293-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 0/2] CODING_STYLE: trivial update
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: mjt@tls.msk.ru, imammedo@redhat.com, philmd@redhat.com, eblake@redhat.com, peter.maydell@linaro.org, Wei Yang <richardw.yang@linux.intel.com>

The first one is suggested by Igor Mammedov to provide rule for multiline
code.

The second is a trivial fix to make example code all indented with 4 spaces.

v3:
  * fix typo in both changelog and example
v2:
  * adjust Patch 1 as suggested by Eric

Wei Yang (2):
  CODING_STYLE: specify the indent rule for multiline code
  CODING_STYLE: indent example code as all others

 CODING_STYLE | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

-- 
2.19.1
