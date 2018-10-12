Received: from eggs.gnu.org ([2001:4830:134:3::10]:55626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gAv7m-0002PS-1y
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 06:56:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gAv7k-0008Q5-HU
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 06:56:53 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:33857)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gAv7k-0008OC-7L
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 06:56:52 -0400
Received: by mail-ot1-x335.google.com with SMTP id v2so4820850otk.1
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 03:56:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181011192513.63634-1-dgilbert@redhat.com>
References: <20181011192513.63634-1-dgilbert@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Oct 2018 11:56:30 +0100
Message-ID: <CAFEAcA-HcHuk9atGne3jFmwVjjqQHCQYJG-j9-Y3jMzQg1dKtw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/7] migration queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>, Wei Huang <wei@redhat.com>, i.maximets@samsung.com, Thomas Huth <thuth@redhat.com>, "Denis V. Lunev" <den@openvz.org>

On 11 October 2018 at 20:25, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> The following changes since commit 75e50c80e051423a6f55a34ee4a1eec842444a5b:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-misc-2018-10-10' into staging (2018-10-11 10:43:37 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/dagrh/qemu.git tags/pull-migration-20181011a
>
> for you to fetch changes up to 36bd9e3c8b049cb9124e04ed8bf8f9451d63de03:
>
>   migration-test: Only generate a single target architecture (2018-10-11 19:58:26 +0100)
>
> ----------------------------------------------------------------
> Migration pull 2018-10-11
>
> With one bonus HMP/PCI fix from Denis.
>
> ----------------------------------------------------------------
> Denis V. Lunev (1):
>       qmp, hmp: make subsystem/system-vendor identities optional
>
> Ilya Maximets (3):
>       migration: Stop postcopy fault thread before notifying
>       vhost-user: Fix userfaultfd leak
>       vhost-user: Don't ask for reply on postcopy mem table set
>
> Juan Quintela (1):
>       migration-test: Only generate a single target architecture
>
> Thomas Huth (1):
>       tests/migration: Enable the migration test on s390x, too
>
> Wei Huang (1):
>       tests: Add migration test for aarch64

Applied, thanks.

-- PMM
