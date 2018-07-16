Received: from eggs.gnu.org ([2001:4830:134:3::10]:46065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ff6Cp-00021D-Vd
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 12:18:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ff6Cp-0004PZ-0k
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 12:18:35 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:40660)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ff6Co-0004PR-Q8
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 12:18:34 -0400
Received: by mail-oi0-x243.google.com with SMTP id w126-v6so75860012oie.7
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 09:18:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180716140514.1490-1-armbru@redhat.com>
References: <20180716140514.1490-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Jul 2018 17:18:13 +0100
Message-ID: <CAFEAcA-kawsUaj9dNTKmtd210pMSDBC-HFA8W-7DExwzb7NaBA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/5] Miscellaneous patches for 2018-07-16
 (3.0.0-rc1)
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

On 16 July 2018 at 15:05, Markus Armbruster <armbru@redhat.com> wrote:
> The following changes since commit 633e824037210a60c0b23d6c0e42420db1fe4c08:
>
>   Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-3.0-20180716' into staging (2018-07-16 11:04:24 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-misc-2018-07-16
>
> for you to fetch changes up to 8720e63e09fa1e48dbd244d89d6fed6b5c50889d:
>
>   monitor: Fix tracepoint crash on JSON syntax error (2018-07-16 15:46:57 +0200)
>
> ----------------------------------------------------------------
> Miscellaneous patches for 2018-07-16 (3.0.0-rc1)
>
> This pull request consists of a late but necessary external interface
> update, a documentation rearrangement to make tracking feature
> deprecation easier, and a crash bug fix.
>
> ----------------------------------------------------------------
Applied, thanks.

-- PMM
