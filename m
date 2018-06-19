Received: from eggs.gnu.org ([2001:4830:134:3::10]:52237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fVIBm-0003SO-9w
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:04:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fVIBg-0003kS-EF
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:04:58 -0400
Received: from mail-oi0-x22b.google.com ([2607:f8b0:4003:c06::22b]:38356)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fVIBg-0003jx-5j
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:04:52 -0400
Received: by mail-oi0-x22b.google.com with SMTP id d5-v6so10627oib.5
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 08:04:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180618140854.17824-1-armbru@redhat.com>
References: <20180618140854.17824-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Jun 2018 16:04:31 +0100
Message-ID: <CAFEAcA-ECqYrKBcp5j2prg18G4TK2QCcE=mz9sewHuw70OY2gQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/7] monitor: Thread safety improvements
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

On 18 June 2018 at 15:08, Markus Armbruster <armbru@redhat.com> wrote:
> The following changes since commit 2ef2f16781af9dee6ba6517755e9073ba5799fa2:
>
>   Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-20180615a' into staging (2018-06-15 18:13:35 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-monitor-2018-06-18
>
> for you to fetch changes up to 474514668b47c9d2148b526e379ffbb6764d9a9e:
>
>   monitor: add lock to protect mon_fdsets (2018-06-18 15:48:22 +0200)
>
> ----------------------------------------------------------------
> Monitor patches for 2018-06-18
>
> ----------------------------------------------------------------


Applied, thanks.

-- PMM
