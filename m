Received: from eggs.gnu.org ([2001:4830:134:3::10]:47612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cJwsr-0001rz-JH
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 01:29:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cJwso-00017T-GZ
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 01:29:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33404)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cJwso-00017E-AJ
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 01:29:42 -0500
Date: Thu, 22 Dec 2016 14:22:00 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20161222062200.GB12950@lemon>
References: <c532ac07-fd54-eedb-b3f0-548aeacf0a04@fam-schranz.de>
	<3dce9a63-6472-54c2-3455-52521a0a3651@redhat.com>
	<89d9fe09-3bdc-3c84-3ddf-f9462adb2068@fam-schranz.de>
	<20161220234738.GB2994@lemon>
	<3512163a-f8c7-f4b7-7bd1-89675c74a1ac@fam-schranz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3512163a-f8c7-f4b7-7bd1-89675c74a1ac@fam-schranz.de>
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

On Wed, 12/21 05:44, Holger Schranz wrote:
> Hi Fam,
> 
> meanwhile I have sent the requested QEMU CLI direct to John. Your request
> I will try after the reinstall with the released version.So please wait
> for a while.

I don't see the command line, but looking at the other info, the question to ask
is why guest cannot see the controller.. Maybe it's a driver issue? Do other
types of guest work for you?

Fam
