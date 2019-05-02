Received: from eggs.gnu.org ([209.51.188.92]:51590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hM9WR-00005b-3q
	for qemu-devel@nongnu.org; Thu, 02 May 2019 07:05:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hM9WM-0006i6-Rz
	for qemu-devel@nongnu.org; Thu, 02 May 2019 07:05:01 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332]:43778)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hM9WK-0006eB-GS
	for qemu-devel@nongnu.org; Thu, 02 May 2019 07:04:58 -0400
Received: by mail-ot1-x332.google.com with SMTP id e108so1634117ote.10
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 04:04:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190501105904.29907-1-dgilbert@redhat.com>
In-Reply-To: <20190501105904.29907-1-dgilbert@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 May 2019 12:04:38 +0100
Message-ID: <CAFEAcA-RkbwHbAigw7cezfVbCPspahBNEn_J1LCvcYYRjFg+vw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] hmp queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Cole Robinson <crobinso@redhat.com>

On Wed, 1 May 2019 at 12:00, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
>
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> The following changes since commit f75d15231e56cb0f2bafe19faf1229c459a60731:
>
>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2019-04-30 17:06:57 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/dagrh/qemu.git tags/pull-hmp-20190501
>
> for you to fetch changes up to 574d96933ceff60b2d13fe97602572fc7e95f7c6:
>
>   hmp: gva2gpa debug command (2019-05-01 10:46:59 +0100)
>
> ----------------------------------------------------------------
> HMP pull
>
> New gva2gpa command
> delvm now uses hmp_handle_error so gets Error: prefix in messages
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM
