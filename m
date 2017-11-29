Received: from eggs.gnu.org ([2001:4830:134:3::10]:39110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eK4rf-0005c4-BZ
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 11:05:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eK4re-0002b3-Bf
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 11:05:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46642)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eK4re-0002ao-5A
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 11:05:34 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 52CF26A7D9
	for <qemu-devel@nongnu.org>; Wed, 29 Nov 2017 16:05:33 +0000 (UTC)
References: <20171129153116.26243-1-eblake@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d22a260e-c3b9-035e-1a9b-3d6021234906@redhat.com>
Date: Wed, 29 Nov 2017 17:05:26 +0100
MIME-Version: 1.0
In-Reply-To: <20171129153116.26243-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-web PATCH] Mention website maintainence
 under Contribute
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com

On 29/11/2017 16:31, Eric Blake wrote:
> Web (and other doc) updates are also valid contributions.
> 
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  contribute.md | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/contribute.md b/contribute.md
> index bf4a55d..88baee6 100644
> --- a/contribute.md
> +++ b/contribute.md
> @@ -12,4 +12,6 @@ permalink: /contribute/
>  * Chat with the developers on IRC: irc.oftc.net, channel #qemu
> 
>  * Read developer documentation: &ldquo;[Getting started for developers](https://wiki.qemu.org/Documentation/GettingStartedDevelopers)&rdquo;,
> -  &ldquo;[Contributor FAQ](https://wiki.qemu.org/Contribute/FAQ)&rdquo;, &ldquo;[How to submit a patch](https://wiki.qemu.org/Contribute/SubmitAPatch)&rdquo;
> +  &ldquo;[Contributor FAQ](https://wiki.qemu.org/Contribute/FAQ)&rdquo;,
> +  &ldquo;[How to submit a patch](https://wiki.qemu.org/Contribute/SubmitAPatch)&rdquo;,
> +  &ldquo;[Improve the website](https://www.qemu.org/2017/02/04/the-new-qemu-website-is-up/)&rdquo;
> 

Applied, thanks.

Paolo
