Received: from eggs.gnu.org ([2001:4830:134:3::10]:59007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ejQsF-0002ZE-SP
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 09:39:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ejQsF-0000a0-5l
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 09:38:59 -0500
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:33416)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ejQsF-0000Zp-0L
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 09:38:59 -0500
Received: by mail-oi0-x241.google.com with SMTP id l8so809698oig.0
	for <qemu-devel@nongnu.org>; Wed, 07 Feb 2018 06:38:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180206154936.13565-1-dgilbert@redhat.com>
References: <20180206154936.13565-1-dgilbert@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 7 Feb 2018 14:38:37 +0000
Message-ID: <CAFEAcA-89o1J3T4ud=KheAUnQbpn7=0K_-jt7x32SHYOsoU-LQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/14] migration queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Greg Kurz <groug@kaod.org>, Peter Xu <peterx@redhat.com>, Ross Lagerwall <ross.lagerwall@citrix.com>, wei.w.wang@intel.com, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

On 6 February 2018 at 15:49, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> The following changes since commit 2b3805f370521deacab974b9c9ca07d2319a8890:
>
>   Merge remote-tracking branch 'remotes/stefanberger/tags/pull-tpm-2018-02-03-1' into staging (2018-02-05 09:31:37 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/dagrh/qemu.git tags/pull-migration-20180206a
>
> for you to fetch changes up to 875fcd013ab68c64802998b22f54f0184479d21b:
>
>   migration: incoming postcopy advise sanity checks (2018-02-06 14:53:02 +0000)
>
> ----------------------------------------------------------------
> Migration pull 2018-02-06
>
> This is based off Juan's last pull with a few extras, but
> also removing:
>    Add migration xbzrle test
>    Add migration precopy test
>
> As well as my normal test boxes, I also gave it a test
> on a 32 bit ARM box and it seems happy (a Calxeda highbank)
> and a big-endian power box.
>
> Dave

Applied, thanks.

-- PMM
