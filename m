Received: from eggs.gnu.org ([2001:4830:134:3::10]:49333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gAwjM-0007UI-Rr
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 08:39:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gAwjM-0000HP-3y
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 08:39:48 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:41190)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gAwjL-0000Gs-LP
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 08:39:48 -0400
Received: by mail-oi1-x244.google.com with SMTP id l197-v6so9729467oib.8
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 05:39:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181012100101.29058-1-cohuck@redhat.com>
References: <20181012100101.29058-1-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Oct 2018 13:39:26 +0100
Message-ID: <CAFEAcA_=2uB7SXQONWJvBX-ziB2m8fqzpbh_=zdaOhB4wW4s6Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/8] s390x updates
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

On 12 October 2018 at 11:00, Cornelia Huck <cohuck@redhat.com> wrote:
> The following changes since commit 75e50c80e051423a6f55a34ee4a1eec842444a5b:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-misc-2018-10-10' into staging (2018-10-11 10:43:37 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/cohuck/qemu tags/s390x-20181012
>
> for you to fetch changes up to 0161215d435ef5680c4623bcbdfe89ce5b35cf42:
>
>   hw/s390x: Include the tod-qemu also for builds with --disable-tcg (2018-10-12 11:32:19 +0200)
>
> ----------------------------------------------------------------
> More s390x updates:
> - introduce support for vfio-ap (s390 crypto devices), including a
>   Linux headers update to get the new interfaces
> - the usual fixing + cleanup
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
