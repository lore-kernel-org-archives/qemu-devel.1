Received: from eggs.gnu.org ([2001:4830:134:3::10]:51789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dKm3Z-0007P2-Tr
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 09:40:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dKm3Y-0003gV-V3
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 09:40:29 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:34182)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dKm3Y-0003gA-OG
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 09:40:28 -0400
Received: by mail-wr0-x233.google.com with SMTP id g76so136925917wrd.1
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 06:40:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170613095120.11373-1-quintela@redhat.com>
References: <20170613095120.11373-1-quintela@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Jun 2017 14:40:05 +0100
Message-ID: <CAFEAcA8QofG_t0=AmHE_gnZDGOmK7XxE2bTmFO2HVxzJSoWQxg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/14] Migration PULL request
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

On 13 June 2017 at 10:51, Juan Quintela <quintela@redhat.com> wrote:
> Hi
>
> This pull request includes:
> - don't set errp directly (eduardo)
> - isolate return path (peter)
> - rest of consistent output series
> - 10 first patches of the misc cleanup series
>
> Please, apply.
>
> Thanks, Juan.
>
> The following changes since commit 9bba618f18b1a60a3f2668db82b453f6cd9467c0:
>
>   Merge remote-tracking branch 'remotes/elmarco/tags/char-pull-request' into staging (2017-06-12 19:26:49 +0100)
>
> are available in the git repository at:
>
>   git://github.com/juanquintela/qemu.git tags/migration/20170613
>
> for you to fetch changes up to 6666c96aac9151568736226dec99aa8acb14d07c:
>
>   migration: Move migration.h to migration/ (2017-06-13 11:00:45 +0200)
>
> ----------------------------------------------------------------
> migration/next for 20170613
>

Applied, thanks.

-- PMM
