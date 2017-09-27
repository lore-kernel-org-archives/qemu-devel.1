Received: from eggs.gnu.org ([2001:4830:134:3::10]:46332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dx9qa-0007WM-JJ
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 06:45:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dx9qV-0003wP-KO
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 06:45:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47724)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dx9qV-0003vz-EE
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 06:45:39 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 425C75F7BB
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 10:45:38 +0000 (UTC)
Message-ID: <1506509136.25036.7.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 27 Sep 2017 12:45:36 +0200
In-Reply-To: <20170927091531.GA12223@redhat.com>
References: <20170926111757.3628-1-kraxel@redhat.com>
	<7f50b7bb-bbf7-7e0e-754a-234d4244fb72@redhat.com>
	<20170927091531.GA12223@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/1] qemu-firmware repo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

  Hi,

> The other bits of mention are all built normally as part of QEMU and
> not subject to these problems,

Sure?  As far I know no firmware is build automatically as cross
compilers might be needed to do that for guest arch != host arch.

But yes, we don't have licensing issues (we ship the sources too),
so keeping them in the main repo isn't that a big issue.

cheers,
  Gerd
