Received: from eggs.gnu.org ([2001:4830:134:3::10]:40641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nt_mahmood@yahoo.com>) id 1dnMo9-00016H-GG
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 06:34:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nt_mahmood@yahoo.com>) id 1dnMo6-0005D6-DJ
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 06:34:45 -0400
Received: from sonic305-19.consmr.mail.gq1.yahoo.com ([98.137.64.82]:45600)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nt_mahmood@yahoo.com>)
	id 1dnMo6-0005CP-72
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 06:34:42 -0400
Date: Thu, 31 Aug 2017 10:34:35 +0000 (UTC)
From: Mahmood <nt_mahmood@yahoo.com>
Reply-To: Mahmood <nt_mahmood@yahoo.com>
Message-ID: <655077175.310569.1504175675199@mail.yahoo.com>
In-Reply-To: <20170830192838.5bb5a45c@bahia>
References: <1915302638.2814146.1504030043465.ref@mail.yahoo.com>
	<1915302638.2814146.1504030043465@mail.yahoo.com>
	<14033890-2a35-666c-2fa7-5a8727090801@tuxfamily.org>
	<1075529669.195794.1504079702032@mail.yahoo.com>
	<bc7bacd9-fec7-c193-6de0-99d1f7fd0f6f@tuxfamily.org>
	<2061420835.208824.1504085337258@mail.yahoo.com>
	<20170830121109.7fab5559@bahia>
	<61cd0715-27e4-7e50-1e85-9da3b4a48bb1@posteo.de>
	<47171733.403781.1504103700042@mail.yahoo.com>
	<20170830192838.5bb5a45c@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-discuss] Accessing a shared folder
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Thomas Huth <huth@tuxfamily.org>, "qemu-discuss@nongnu.org" <qemu-discuss@nongnu.org>, Thomas Huth <th.huth@posteo.de>, QEMU Developers <qemu-devel@nongnu.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

Hello again,
For the command

=C2=A0=C2=A0=C2=A0 mount -t 9p -o trans=3Dvirtio Downloads /media/Downloads

inside the Centos-7 guest, I get this error

mount: unknown filesystem type '9p'

Any thought?

Regards,
Mahmood
