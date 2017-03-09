Received: from eggs.gnu.org ([2001:4830:134:3::10]:51157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <oussemakeder@yahoo.fr>) id 1cm0T8-0007tc-Dr
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 10:59:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <oussemakeder@yahoo.fr>) id 1cm0T5-0008IZ-Ck
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 10:59:10 -0500
Received: from nm9-vm1.bullet.mail.ir2.yahoo.com ([212.82.96.144]:38806)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <oussemakeder@yahoo.fr>) id 1cm0T5-0008IN-0R
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 10:59:07 -0500
Date: Thu, 9 Mar 2017 15:59:02 +0000 (UTC)
From: oussema ben khedher <oussemakeder@yahoo.fr>
Reply-To: oussema ben khedher <oussemakeder@yahoo.fr>
Message-ID: <1221104956.3749086.1489075142127@mail.yahoo.com>
MIME-Version: 1.0
References: <1221104956.3749086.1489075142127.ref@mail.yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] about restore the pc of the guest code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

hi 

i search the pc of tb in the guest code i used the function cpu_restore_state_from_tb in cpu_exec_tb but the searching pc take 0 value can someone explain me why searching_pc is 0 or give me some hints 
thanks
