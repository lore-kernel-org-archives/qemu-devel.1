Received: from eggs.gnu.org ([2001:4830:134:3::10]:46246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ec9ml-0005VT-SN
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 07:59:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ec9mk-0001Bl-Aw
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 07:59:15 -0500
Received: from mail-ot0-x234.google.com ([2607:f8b0:4003:c0f::234]:41036)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ec9mk-0001BP-2K
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 07:59:14 -0500
Received: by mail-ot0-x234.google.com with SMTP id 44so19090335otk.8
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 04:59:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180117022525.31767-1-david@gibson.dropbear.id.au>
References: <20180117022525.31767-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jan 2018 12:58:52 +0000
Message-ID: <CAFEAcA8JO_53X_0n3yKgEWKaQ5XMWNw7xCQQ4JnD2FhigWK=iQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/22] ppc-for-2.12 queue 20180117
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Greg Kurz <groug@kaod.org>, surajjs@au1.ibm.com, qemu-ppc@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>, Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>, Laurent Vivier <lvivier@redhat.com>

On 17 January 2018 at 02:25, David Gibson <david@gibson.dropbear.id.au> wrote:
> The following changes since commit 8e5dc9ba49743b46d955ec7dacb04e42ae7ada7c:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20180116' into staging (2018-01-16 17:36:39 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-2.12-20180117
>
> for you to fetch changes up to 2e569845bd314fc1dde83d65dc9b87e71b4d29b4:
>
>   target-ppc: Fix booke206 tlbwe TLB instruction (2018-01-17 09:35:24 +1100)
>
> This pull request hasn't been through a Travis build, unfortunately,
> since Travis seems to have a gigantic backlog today.  I've run all the
> rest of my usual tests, and I did get a Travis build of this branch
> before the latest minor rebase, so it's unlikely there's a problem
> there.
>

Applied, thanks.

-- PMM
