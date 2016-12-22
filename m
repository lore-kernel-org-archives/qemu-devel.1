Received: from eggs.gnu.org ([2001:4830:134:3::10]:35310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cK34u-0003LU-9z
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 08:06:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cK34t-0007hE-Fa
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 08:06:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50262)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cK34t-0007gE-Aa
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 08:06:35 -0500
Date: Thu, 22 Dec 2016 21:06:31 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20161222130631.GA21139@lemon>
References: <c532ac07-fd54-eedb-b3f0-548aeacf0a04@fam-schranz.de>
	<3dce9a63-6472-54c2-3455-52521a0a3651@redhat.com>
	<89d9fe09-3bdc-3c84-3ddf-f9462adb2068@fam-schranz.de>
	<20161220234738.GB2994@lemon>
	<3512163a-f8c7-f4b7-7bd1-89675c74a1ac@fam-schranz.de>
	<20161222062200.GB12950@lemon>
	<cbaa842d-d894-75f0-4cff-8030b317f2de@fam-schranz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbaa842d-d894-75f0-4cff-8030b317f2de@fam-schranz.de>
Subject: Re: [Qemu-devel] Strange/wrong behavior with iSCSI Tape devices in
 QEMU 2.8.0-rc4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Holger Schranz <holger@fam-schranz.de>
Cc: mueller-ralf@t-online.de, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org

On Thu, 12/22 13:33, Holger Schranz wrote:
> Hi Fam,
> 
> You win !!!
> 
> I have installed an RH 7.7 based on kernel 3.10 and a SuSE LEAP 42.2 which
> is based on kernel 4.4. Both system see the tape devices and can work.
> Than I restart in the same session the VM with SLES11 SP4 (kernel 3.0.101)
> and an older RH based on kernel 2.6. This both system can't see the tape
> drives.
> But all 5 VM guest systems are registered in iscsi and show the UUID of the
> guest system.
> 
> Please, what should I do as a next step please?

Could you post your full qemu command line?

Fam
