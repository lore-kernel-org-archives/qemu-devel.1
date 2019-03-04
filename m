Received: from eggs.gnu.org ([209.51.188.92]:45511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1h0hqk-0007SH-R7
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 02:17:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1h0hqk-0007o7-20
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 02:17:22 -0500
From: Wei Yang <richardw.yang@linux.intel.com>
Date: Mon,  4 Mar 2019 15:16:29 +0800
Message-Id: <20190304071631.27567-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 0/2] CODING_STYLE: trivial update
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: mjt@tls.msk.ru, imammedo@redhat.com, philmd@redhat.com, eblake@redhat.com, peter.maydell@linaro.org, sgarzare@redhat.com, Wei Yang <richardw.yang@linux.intel.com>

The first one is suggested by Igor Mammedov to provide rule for multiline
code.

The second is a trivial fix to make example code all indented with 4 spaces.

v6:
  * add ) for last example of function
v5:
  * mostly address function variants
v4:
  * one exception case for function
v3:
  * fix typo in both changelog and example
v2:
  * adjust Patch 1 as suggested by Eric

Wei Yang (2):
  CODING_STYLE: specify the indent rule for multiline code
  CODING_STYLE: indent example code as all others

 CODING_STYLE | 47 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 43 insertions(+), 4 deletions(-)

-- 
2.19.1
