Received: from eggs.gnu.org ([2001:4830:134:3::10]:45077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fwlOg-0006N5-8q
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 05:43:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fwlOc-0003mU-G5
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 05:43:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54966 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fwlOc-0003m4-An
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 05:43:46 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 609A7804B9F1
	for <qemu-devel@nongnu.org>; Mon,  3 Sep 2018 09:43:44 +0000 (UTC)
Date: Mon, 3 Sep 2018 10:43:39 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180903094339.GA3467@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180902175401.8195-1-ybettan@redhat.com>
	<20180902175401.8195-2-ybettan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180902175401.8195-2-ybettan@redhat.com>
Subject: Re: [Qemu-devel] [PATCH V2 1/3] README.md : Formatted to fit
 Markdown (.md) format.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yoni Bettan <ybettan@redhat.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, stefanha@redhat.com

On Sun, Sep 02, 2018 at 08:53:59PM +0300, Yoni Bettan wrote:
> Also updated scripts/checkpatch.pl and made it reference to README.md
> instead of README.
> 
> Signed-off-by: Yoni Bettan <ybettan@redhat.com>
> ---
>  README => README.md   | 89 ++++++++++++++++++++++---------------------
>  scripts/checkpatch.pl |  2 +-
>  2 files changed, 46 insertions(+), 45 deletions(-)
>  rename README => README.md (67%)
> 
> diff --git a/README b/README.md
> similarity index 67%
> rename from README
> rename to README.md
> index 49a9fd09cd..5fc06dcf8a 100644
> --- a/README
> +++ b/README.md
> @@ -1,5 +1,4 @@
> -         QEMU README
> -         ===========
> +# Qemu

It should stay as "QEMU" not "Qemu'

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
