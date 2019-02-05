Received: from eggs.gnu.org ([209.51.188.92]:34816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gqwSf-0003Wj-7D
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 03:52:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gqwSe-00016D-BP
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 03:52:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55826)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gqwSd-00015W-TI
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 03:52:08 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 31B0FE6A6C
	for <qemu-devel@nongnu.org>; Tue,  5 Feb 2019 08:52:07 +0000 (UTC)
Date: Tue, 5 Feb 2019 09:52:06 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190205085206.usmbzb72ieno5u45@sirius.home.kraxel.org>
References: <1549351769-19620-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549351769-19620-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] Remove deprecated -no-frame option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, Feb 05, 2019 at 08:29:29AM +0100, Thomas Huth wrote:
> The -no-frame option has been deprecated with QEMU v2.12. It was only
> useful with SDL1.2 - now that we've removed support for SDL1.2, we
> can certainly remove the -no-frame option, too.

Was about to do that too.  Luckily I checked my mails first ;)
Added to UI queue.

thanks,
  Gerd
