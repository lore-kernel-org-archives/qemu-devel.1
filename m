Received: from eggs.gnu.org ([209.51.188.92]:37311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1gvuHI-0007JE-3k
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 20:32:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1gvuHB-0002Vh-G7
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 20:32:53 -0500
From: Wei Yang <richardw.yang@linux.intel.com>
Date: Tue, 19 Feb 2019 09:31:04 +0800
Message-Id: <20190219013106.17538-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/2] CODING_STYLE: trivial update
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: mjt@tls.msk.ru, imammedo@redhat.com, Wei Yang <richardw.yang@linux.intel.com>

The first one is suggested by Igor Mammedov to provide rule for multiline
code.

The second is a trivial fix to make example code all indented with 4 spaces.

Wei Yang (2):
  CODING_STYLE: specify the indent rule for multiline code
  CODING_STYLE: indent example code as all others

 CODING_STYLE | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

-- 
2.19.1
