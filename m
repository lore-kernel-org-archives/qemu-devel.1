Received: from eggs.gnu.org ([2001:4830:134:3::10]:44436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gMC7B-00078J-45
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 08:18:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gMC74-00023e-Ri
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 08:18:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33380)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gMC73-00020r-I2
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 08:18:46 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 12555C049D7F
	for <qemu-devel@nongnu.org>; Mon, 12 Nov 2018 13:18:36 +0000 (UTC)
Date: Mon, 12 Nov 2018 14:18:35 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181112131835.xccqqvhu63xhh7pk@sirius.home.kraxel.org>
References: <20181030082340.17170-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181030082340.17170-1-kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] fmops: fix off-by-one in AR_TABLE and
 DR_TABLE array size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: P J P <ppandit@redhat.com>

On Tue, Oct 30, 2018 at 09:23:40AM +0100, Gerd Hoffmann wrote:
> Fixes: CVE-2018-???
> Cc: P J P <ppandit@redhat.com>

ping, do we have a cve number meanwhile?

cheers,
  Gerd
