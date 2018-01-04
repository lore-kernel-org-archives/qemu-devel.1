Received: from eggs.gnu.org ([2001:4830:134:3::10]:47004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <s.priebe@profihost.ag>) id 1eWyzd-00013K-AN
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 01:27:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <s.priebe@profihost.ag>) id 1eWyzY-0004bm-Dn
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 01:27:09 -0500
Received: from cloud1-vm154.de-nserver.de ([178.250.10.56]:44627)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <s.priebe@profihost.ag>)
	id 1eWyzY-0004aX-3K
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 01:27:04 -0500
From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Message-ID: <6d95cc4b-155c-44cb-1fc0-18ba848741ac@profihost.ag>
Date: Thu, 4 Jan 2018 07:27:01 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] CVE-2017-5715: relevant qemu patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>

Hello,

i've seen some vendors have updated qemu regarding meltdown / spectre.

f.e.:

 CVE-2017-5715: QEMU was updated to allow passing through new MSR and
     CPUID flags from the host VM to the CPU, to allow enabling/disabling
     branch prediction features in the Intel CPU. (bsc#1068032)

Can anybody point me to the relevant qemu patches?

Thanks!

Greets,
Stefan
