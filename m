Received: from eggs.gnu.org ([2001:4830:134:3::10]:44816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cWL1p-00028q-DB
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 05:42:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cWL1o-0005Y1-GM
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 05:42:13 -0500
Received: from mail-vk0-x231.google.com ([2607:f8b0:400c:c05::231]:34357)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cWL1o-0005Xn-Bd
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 05:42:12 -0500
Received: by mail-vk0-x231.google.com with SMTP id r136so131059832vke.1
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 02:42:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170124184742.1639-1-dgilbert@redhat.com>
References: <20170124184742.1639-1-dgilbert@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 25 Jan 2017 10:41:51 +0000
Message-ID: <CAFEAcA-5WXnRxW=nCPazLqxMhDoyOD2Strrzm7-mHozYaeXAwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 00/15] migration queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 24 January 2017 at 18:47, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> The following changes since commit a678502e4f7580a6f143f680404aaee57ac3f4b5:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/x86-and-machine-pull-request' into staging (2017-01-24 15:39:09 +0000)
>
> are available in the git repository at:
>
>   git://github.com/dagrh/qemu.git tags/pull-migration-20170124b
>
> for you to fetch changes up to 46a02a745176e1ef30de41706b5da4f1bc7fc495:
>
>   migration/tracing: Add tracing on save (2017-01-24 18:00:32 +0000)
>
> ----------------------------------------------------------------
> Migration
>
> 1 My maintainer change
> 2 Jianjun's qtailq
> 3 Ashijeet's only-migratable
> 4 Zhanghailiang's re-active images
> 5 Pankaj's change name of migration thread
> 6 My PCI migration merge
> 7 Juan's debug to tracing
> 8 My tracing on save
>

Applied, thanks.

-- PMM
