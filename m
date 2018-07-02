Received: from eggs.gnu.org ([2001:4830:134:3::10]:47267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fa0QI-0001BM-AD
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:07:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fa0QH-0006BC-HT
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:07:26 -0400
Received: from mail-oi0-x233.google.com ([2607:f8b0:4003:c06::233]:46377)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fa0QH-0006Ar-CE
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:07:25 -0400
Received: by mail-oi0-x233.google.com with SMTP id y207-v6so16959706oie.13
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 08:07:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180702111737.18970-1-cohuck@redhat.com>
References: <20180702111737.18970-1-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Jul 2018 16:07:04 +0100
Message-ID: <CAFEAcA82z==EhKDZMvsZXruMc=+Cj7bR9vLTAiC6wqZavxvCcA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/15] s390x patches for 3.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x <qemu-s390x@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 2 July 2018 at 12:17, Cornelia Huck <cohuck@redhat.com> wrote:
> The following changes since commit 281bd281222776229d5dbf84d1a5c6d8d9d2a34b:
>
>   Merge remote-tracking branch 'remotes/xtensa/tags/20180630-xtensa' into staging (2018-06-30 22:23:51 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/cohuck/qemu tags/s390x-20180702
>
> for you to fetch changes up to 30c8db0e219a3c1d8b39c19e8b858830cb141738:
>
>   s390x/tcg: fix locking problem with tcg_s390_tod_updated (2018-07-02 10:37:38 +0200)
>
> ----------------------------------------------------------------
> s390x updates:
> - add bpb/ppa15 features to default cpu model for z196 and later
> - rework TOD handling and fix cpu hotplug under tcg
> - various fixes
>

Applied, thanks.

-- PMM
