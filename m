Received: from eggs.gnu.org ([2001:4830:134:3::10]:37891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cr31i-0007WH-Tq
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 09:43:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cr31h-00033g-Oa
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 09:43:42 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:34148)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cr31h-00033c-Hr
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 09:43:41 -0400
Received: by mail-wr0-x22d.google.com with SMTP id l37so147923451wrc.1
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 06:43:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1490207781-18965-1-git-send-email-armbru@redhat.com>
References: <1490207781-18965-1-git-send-email-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Mar 2017 13:43:19 +0000
Message-ID: <CAFEAcA8vc=qCJ6Q0Mk4NvsZ3r8J_3YE6HmZ7gL8vsVPutSY9Mg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL v3 for-2.9 00/17] QAPI patches for 2017-03-22
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 22 March 2017 at 18:36, Markus Armbruster <armbru@redhat.com> wrote:
> v3 (third time's a charm)
> * Actually squash it into 16/17, not 17/17
> v2:
> * Leak fix squashed into 16/17
>
> The following changes since commit 940a8ce075e3408742a4edcabfd6c2a15e2539eb:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2017-03-20 16:34:26 +0000)
>
> are available in the git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2017-03-22-v3
>
> for you to fetch changes up to 21f88d021d0d2b4ecee8f6cd6ca63a943a3ce71d:
>
>   qapi: Fix QemuOpts visitor regression on unvisited input (2017-03-22 19:24:34 +0100)
>
> ----------------------------------------------------------------
> QAPI patches for 2017-03-22
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
