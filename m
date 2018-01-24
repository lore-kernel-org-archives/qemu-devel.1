Received: from eggs.gnu.org ([2001:4830:134:3::10]:41820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eeMye-00015S-El
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 10:28:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eeMyd-0006ca-Ki
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 10:28:40 -0500
Received: from mail-ot0-x230.google.com ([2607:f8b0:4003:c0f::230]:37804)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eeMyd-0006cI-FF
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 10:28:39 -0500
Received: by mail-ot0-x230.google.com with SMTP id a24so3890298otd.4
	for <qemu-devel@nongnu.org>; Wed, 24 Jan 2018 07:28:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180122120045.13538-1-cohuck@redhat.com>
References: <20180122120045.13538-1-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 24 Jan 2018 15:28:18 +0000
Message-ID: <CAFEAcA96cw0Fe2nYc05+q3W445HNbOixnhLNvUQGATSENmSCmw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/9] s390x update
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>

On 22 January 2018 at 12:00, Cornelia Huck <cohuck@redhat.com> wrote:
> The following changes since commit b384cd95eb9c6f73ad84ed1bb0717a26e29cc78f:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/machine-next-pull-request' into staging (2018-01-19 16:35:25 +0000)
>
> are available in the git repository at:
>
>   git://github.com/cohuck/qemu tags/s390x-20180122
>
> for you to fetch changes up to 9f0d13f4f1de3cf9b70435cc4e87a301ee12471f:
>
>   s390x/kvm: provide stfle.81 (2018-01-22 11:22:43 +0100)
>
> ----------------------------------------------------------------
> Various fixes/improvements, and support for the new 81/82
> facility bits.
>
> ----------------------------------------------------------------
>

Applied, thanks.

-- PMM
