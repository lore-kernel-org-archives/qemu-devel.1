Received: from eggs.gnu.org ([2001:4830:134:3::10]:45714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <s.priebe@profihost.ag>) id 1eX51r-0002QI-Ek
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 07:53:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <s.priebe@profihost.ag>) id 1eX51n-0000FK-7T
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 07:53:51 -0500
Received: from cloud1-vm154.de-nserver.de ([178.250.10.56]:23549)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <s.priebe@profihost.ag>)
	id 1eX51m-0000Bx-RK
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 07:53:47 -0500
From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
References: <6d95cc4b-155c-44cb-1fc0-18ba848741ac@profihost.ag>
Message-ID: <4baad7ed-8f1f-3f7a-c051-a12dd9a030ac@profihost.ag>
Date: Thu, 4 Jan 2018 13:53:44 +0100
MIME-Version: 1.0
In-Reply-To: <6d95cc4b-155c-44cb-1fc0-18ba848741ac@profihost.ag>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] CVE-2017-5715: relevant qemu patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>

Nobody? Is this something they did on their own?

Stefan

Am 04.01.2018 um 07:27 schrieb Stefan Priebe - Profihost AG:
> Hello,
> 
> i've seen some vendors have updated qemu regarding meltdown / spectre.
> 
> f.e.:
> 
>  CVE-2017-5715: QEMU was updated to allow passing through new MSR and
>      CPUID flags from the host VM to the CPU, to allow enabling/disabling
>      branch prediction features in the Intel CPU. (bsc#1068032)
> 
> Can anybody point me to the relevant qemu patches?
> 
> Thanks!
> 
> Greets,
> Stefan
> 
