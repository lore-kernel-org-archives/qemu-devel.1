Received: from eggs.gnu.org ([2001:4830:134:3::10]:52125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dsPna-0002kz-7o
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 04:47:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dsPnU-0003lW-TH
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 04:47:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38518)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dsPnU-0003jc-MI
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 04:46:56 -0400
Message-ID: <1505378813.31557.7.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 14 Sep 2017 10:46:53 +0200
In-Reply-To: <edda99a2-37b3-7428-027c-18f27a315056@redhat.com>
References: <cover.1505225353.git.alifm@linux.vnet.ibm.com>
	<edda99a2-37b3-7428-027c-18f27a315056@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 0/2] Virtio GPU for S390
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Farhan Ali <alifm@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, cohuck@redhat.com

  Hi,

> Do you have a list of CONFIG options that need to be enabled there?
> Are there also any patches to the guest kernel driver required?

guest kernel driver should be fine, it works for ppc64 (big endian)
guests.

cheers,
  Gerd
