Received: from eggs.gnu.org ([2001:4830:134:3::10]:47247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fb0by-0005Be-RJ
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 05:31:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fb0bx-0007x6-Sw
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 05:31:38 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:42001)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fb0bx-0007v4-Mv
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 05:31:37 -0400
Received: by mail-oi0-x244.google.com with SMTP id n84-v6so15565256oib.9
	for <qemu-devel@nongnu.org>; Thu, 05 Jul 2018 02:31:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180703205221.24788-1-mdroth@linux.vnet.ibm.com>
References: <20180703205221.24788-1-mdroth@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Jul 2018 10:31:16 +0100
Message-ID: <CAFEAcA-AhzxU+7K5Dm-xj2aGvcr39A3zdzwQCTzKh+05h08gyg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/14] qga patch queue for soft-freeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 3 July 2018 at 21:52, Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
> Hi Peter,
>
> Sorry for the last-minute pull request. Most of these have been on the list
> for a while now waiting to be applied. Please consider pulling these in.
>
> The following changes since commit b07cd3e748b3f27a17c27afeee578dc4eedb8dd5:
>
>   Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-3.0-20180703' into staging (2018-07-03 14:59:27 +0100)
>
> are available in the git repository at:
>
>   git://github.com/mdroth/qemu.git tags/qga-pull-2018-07-03-tag
>
> for you to fetch changes up to 73e1d8eb9b738cef3dee2da26bb669b1092a4c12:
>
>   qga: removing bios_supports_mode (2018-07-03 15:20:51 -0500)
>
> ----------------------------------------------------------------
> qemu-ga patch queue for soft-freeze
>
> * add systemd suspend support
> * add used/total space stats for guest-get-fsinfo
> * fixes for guest-get-fsinfo over PCI bridges
> * MSI installer and schema doc fixes
> * guard against unbounded allocations in guest-file-read
> * add some additional qga test cases
>
> ----------------------------------------------------------------
Applied, thanks.

-- PMM
