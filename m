Received: from eggs.gnu.org ([2001:4830:134:3::10]:59249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fJGdl-0007fa-Lq
	for qemu-devel@nongnu.org; Thu, 17 May 2018 07:00:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fJGdc-0000An-Gb
	for qemu-devel@nongnu.org; Thu, 17 May 2018 07:00:09 -0400
Received: from mail-oi0-x229.google.com ([2607:f8b0:4003:c06::229]:43562)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fJGdc-0000AT-Bh
	for qemu-devel@nongnu.org; Thu, 17 May 2018 07:00:00 -0400
Received: by mail-oi0-x229.google.com with SMTP id p62-v6so3565876oie.10
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 04:00:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180515234017.2277-1-quintela@redhat.com>
References: <20180515234017.2277-1-quintela@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 May 2018 11:59:39 +0100
Message-ID: <CAFEAcA_7gBfQHf-DDEf7NSDwFo7yhVyJ8_-m7kCQ8XeK0DsRiQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/40] Migration PULL requset (take 2)
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

On 16 May 2018 at 00:39, Juan Quintela <quintela@redhat.com> wrote:
> Hi
>
> - dropped xbzrle test (have to check with slower systems)
> - fixed s/2.12/2.13/ detected by eric
>
> Please Apply.
>
> The following changes since commit c416eecea5f3aea863ab8fda5a36a24157b8f704:
>
>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2018-05-15 17:02:00 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/juanquintela/qemu.git tags/migration/20180515
>
> for you to fetch changes up to 8b7bf2badac25c0a52aff1b181ad75fdb304dd0c:
>
>   Migration+TLS: Fix crash due to double cleanup (2018-05-15 22:13:08 +0200)
>
> ----------------------------------------------------------------
> migration/next for 20180515
>

Applied, thanks.

-- PMM
