Received: from eggs.gnu.org ([2001:4830:134:3::10]:55105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqHWy-0004Sy-Tx
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 07:33:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqHWu-0006Wp-HZ
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 07:33:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58542)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dqHWu-0006WQ-Bi
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 07:33:00 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5E1BD806A2
	for <qemu-devel@nongnu.org>; Fri,  8 Sep 2017 11:32:59 +0000 (UTC)
Date: Fri, 8 Sep 2017 19:32:55 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170908113255.GO4511@lemon>
References: <20170908111217.21985-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170908111217.21985-1-kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] usb-host: cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>

On Fri, 09/08 13:12, Gerd Hoffmann wrote:
> 
> 
> Gerd Hoffmann (2):
>   usb: drop HOST_USB
>   usb: only build usb-host with CONFIG_USB=y

Reviewed-by: Fam Zheng <famz@redhat.com>
