Received: from eggs.gnu.org ([2001:4830:134:3::10]:33297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1evO60-0005fL-Vj
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 10:06:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1evO5z-0000ro-V9
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 10:06:36 -0400
Received: from mail-oi0-x231.google.com ([2607:f8b0:4003:c06::231]:37000)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1evO5z-0000pk-Pu
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 10:06:35 -0400
Received: by mail-oi0-x231.google.com with SMTP id f186so12383821oig.4
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 07:06:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180309175453.41548-1-dgilbert@redhat.com>
References: <20180309175453.41548-1-dgilbert@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Mar 2018 14:06:14 +0000
Message-ID: <CAFEAcA-8Gt-DhWfdYkf7gDKTEuySU7M9Lc5MEhOEbXmmqfBYuA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/6] migration queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Peter Lieven <pl@kamp.de>, Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>

On 9 March 2018 at 17:54, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> The following changes since commit b39b61e410022f96ceb53d4381d25cba5126ac=
44:
>
>   memory: fix flatview_access_valid RCU read lock/unlock imbalance (2018-=
03-09 15:55:20 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/dagrh/qemu.git tags/pull-migration-20180309a
>
> for you to fetch changes up to f96d6651e4b7cb8a8e91774b9330d82c333171d6:
>
>   tests: Silence migration-test 'bad' test (2018-03-09 17:39:25 +0000)
>
> ----------------------------------------------------------------
> Migration pull 2018-03-09
>
> ----------------------------------------------------------------
> Dr. David Alan Gilbert (1):
>       tests: Silence migration-test 'bad' test
>
> Marc-Andr=C3=A9 Lureau (1):
>       migration: fix minor finalize leak
>
> Peter Lieven (3):
>       migration: do not transfer ram during bulk storage migration
>       migration/block: reset dirty bitmap before read in bulk phase
>       migration/block: rename MAX_INFLIGHT_IO to MAX_IO_BUFFERS
>
> Peter Xu (1):
>       migration: fix applying wrong capabilities
>

Applied, thanks.

-- PMM
