Received: from eggs.gnu.org ([2001:4830:134:3::10]:60106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gPrzL-0001CN-DZ
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 11:38:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gPrzK-00024i-B3
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 11:37:59 -0500
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a]:40870)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gPrzK-00023Y-29
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 11:37:58 -0500
Received: by mail-ot1-x32a.google.com with SMTP id s5so8510615oth.7
	for <qemu-devel@nongnu.org>; Thu, 22 Nov 2018 08:37:57 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181121130456.35661-1-dgilbert@redhat.com>
References: <20181121130456.35661-1-dgilbert@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Nov 2018 16:37:36 +0000
Message-ID: <CAFEAcA_6OGQT3RSCjKTyc6ZdKEGVcb9YdM=wK3nOgeYTreyGDw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] migration queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Zhang Chen <chen.zhang@intel.com>, Zhang Chen <zhangckid@gmail.com>, Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>

On 21 November 2018 at 13:04, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> The following changes since commit 47c1cc30e440860aa695358f7c2dd0b9d7b53d16:
>
>   Update version for v3.1.0-rc2 release (2018-11-20 18:10:26 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/dagrh/qemu.git tags/pull-migration-20181121a
>
> for you to fetch changes up to 7e934f5b27eee1b0d77be3dcf1fd18d4ccc602cc:
>
>   migration/migration.c: Add COLO dependency checks (2018-11-21 11:38:12 +0000)
>
> ----------------------------------------------------------------
> Migration fixes 2018-11-21
>
> Notably the fix for building with --disable-replication
>

Applied, thanks.

-- PMM
