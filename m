Received: from eggs.gnu.org ([2001:4830:134:3::10]:58491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYYqY-0000De-C1
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 11:28:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYYqX-0000mF-Ex
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 11:28:34 -0400
Received: from mail-oi0-x236.google.com ([2607:f8b0:4003:c06::236]:32990)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fYYqX-0000km-81
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 11:28:33 -0400
Received: by mail-oi0-x236.google.com with SMTP id c6-v6so5583613oiy.0
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 08:28:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180627125604.15275-1-quintela@redhat.com>
References: <20180627125604.15275-1-quintela@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Jun 2018 16:28:11 +0100
Message-ID: <CAFEAcA_WsBKZsheMgUy6Z4mxbgM=BYVLNc3p0EMg9sNpKQ4PqA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/16] Migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>

On 27 June 2018 at 13:55, Juan Quintela <quintela@redhat.com> wrote:
> The following changes since commit 00928a421d47f49691cace1207481b7aad31b1f1:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20180626' into staging (2018-06-26 18:23:49 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/juanquintela/qemu.git tags/migration/20180627
>
> for you to fetch changes up to ca273df3014930f4ecb6d3ba24aa778354634b56:
>
>   migration: fix crash in when incoming client channel setup fails (2018-06-27 13:29:35 +0200)
>
> ----------------------------------------------------------------
> migration/next for 20180627
>
> This series contains:
> - fix tls crash (danp)
> - drop unused parameter from postcopy (david)
> - multifd series (me)
>
> Please, apply.
Applied, thanks.

-- PMM
