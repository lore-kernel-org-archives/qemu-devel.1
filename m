Received: from eggs.gnu.org ([2001:4830:134:3::10]:43558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nt_mahmood@yahoo.com>) id 1dn0cs-0002hi-Sl
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 06:53:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nt_mahmood@yahoo.com>) id 1dn0cn-0008Tq-W5
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 06:53:38 -0400
Received: from sonic315-10.consmr.mail.gq1.yahoo.com ([98.137.65.34]:41215)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nt_mahmood@yahoo.com>)
	id 1dn0cn-0008TU-PW
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 06:53:33 -0400
Date: Wed, 30 Aug 2017 10:53:26 +0000 (UTC)
From: Mahmood <nt_mahmood@yahoo.com>
Reply-To: Mahmood <nt_mahmood@yahoo.com>
Message-ID: <1735515901.247981.1504090406495@mail.yahoo.com>
In-Reply-To: <61cd0715-27e4-7e50-1e85-9da3b4a48bb1@posteo.de>
References: <1915302638.2814146.1504030043465.ref@mail.yahoo.com>
	<1915302638.2814146.1504030043465@mail.yahoo.com>
	<14033890-2a35-666c-2fa7-5a8727090801@tuxfamily.org>
	<1075529669.195794.1504079702032@mail.yahoo.com>
	<bc7bacd9-fec7-c193-6de0-99d1f7fd0f6f@tuxfamily.org>
	<2061420835.208824.1504085337258@mail.yahoo.com>
	<20170830121109.7fab5559@bahia>
	<61cd0715-27e4-7e50-1e85-9da3b4a48bb1@posteo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-discuss] Accessing a shared folder
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <th.huth@posteo.de>, Greg Kurz <groug@kaod.org>
Cc: Thomas Huth <huth@tuxfamily.org>, "qemu-discuss@nongnu.org" <qemu-discuss@nongnu.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>


The security_model=none also doesn't work and get the same error.

mahmood@cluster:qemu-vm$ qemu-system-x86_64 -version
QEMU emulator version 1.7.0, Copyright (c) 2003-2008 Fabrice Bellard


I know it is old but I think I installed this version three years ago due to the Rocks-6 version old libraries (which is based on Centos-6). I will try some newer versions to find which version is better.


One more question. How can I uninstall the qemu which is built from source? "make uninstall" in the source folder doesn't work.


Sorry for taking up your time.


Regards,
Mahmood
