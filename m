Received: from eggs.gnu.org ([2001:4830:134:3::10]:50737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1db5CL-0007aE-Vw
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 09:20:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1db5CG-0003x1-Sv
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 09:20:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49062)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1db5CG-0003wB-NH
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 09:20:52 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A1451C0FACF0
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 13:20:51 +0000 (UTC)
Message-ID: <1501248049.10943.16.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 28 Jul 2017 15:20:49 +0200
In-Reply-To: <20170728125935.18167-1-kraxel@redhat.com>
References: <20170728125935.18167-1-kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 0/3] Ui 20170728 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

  Hi,

> ui: more keymap fixes for 2.10

Rushing things a bit, because I'm about to disappear into my summer
vacation, so I want get the fixes out of the door.

This is just incremental fixes to yesterdays (somewhat rushed too) pull
request, so I don't expect more problems.  Should that not be the case:
 Daniel, can you take care while I'm offline?

thanks,
  Gerd
