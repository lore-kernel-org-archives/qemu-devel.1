Received: from eggs.gnu.org ([2001:4830:134:3::10]:34923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dsSjh-0008WN-1k
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 07:55:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dsSjb-00022X-La
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 07:55:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42950)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dsSjb-00021Z-EP
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 07:55:07 -0400
Message-ID: <1505390103.31557.11.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 14 Sep 2017 13:55:03 +0200
In-Reply-To: <20170912143007.GK17633@redhat.com>
References: <20170912123744.14730-1-berrange@redhat.com>
	<1505223994.31639.20.camel@redhat.com>
	<20170912141910.GJ17633@redhat.com>
	<CAFEAcA-tdbzXBkyxXW_e15hVcbcfqSfKqke0PX6y-Cg6A62DzQ@mail.gmail.com>
	<20170912143007.GK17633@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 00/12] Convert over to use keycodemapdb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

  Hi,

> I think a better approach is to have something in rules.mak
> that ensures the submodule is checked out correctly (only
> when building from GIT, not dist), and then have the rules
> which generate the keymap files depend on this.

Care sending a patch doing that for dtc?

cheers,
  Gerd
