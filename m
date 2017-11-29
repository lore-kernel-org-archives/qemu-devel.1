Received: from eggs.gnu.org ([2001:4830:134:3::10]:43920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eK58Z-0003mv-TD
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 11:23:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eK58Y-0003J1-GZ
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 11:23:03 -0500
Received: from mail-ot0-x229.google.com ([2607:f8b0:4003:c0f::229]:43787)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eK58Y-0003Ib-B5
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 11:23:02 -0500
Received: by mail-ot0-x229.google.com with SMTP id y10so3474784otg.10
	for <qemu-devel@nongnu.org>; Wed, 29 Nov 2017 08:23:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171129153116.26243-1-eblake@redhat.com>
References: <20171129153116.26243-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 29 Nov 2017 16:22:40 +0000
Message-ID: <CAFEAcA8RdvDxTkAZdEzdBbFfmXN4GJUU7pydDPk++sPYHJfk8w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Eric Blake <eblake@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>

On 29 November 2017 at 15:31, Eric Blake <eblake@redhat.com> wrote:
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

Ah, I was vaguely thinking about this the other day; that we should
improve https://wiki.qemu.org/Contribute so that it puts contributions
to documentation, the website, etc on a clearer footing that's more
on par with "contribute code" (possibly by hiving off the "writing
code" bits to a separate section).

We now seem to have two landing pages for "start contributing",
though -- one on the main website and one on the wiki.

thanks
-- PMM
