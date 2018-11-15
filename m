Received: from eggs.gnu.org ([2001:4830:134:3::10]:39886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gNFdd-0002I6-0V
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 06:16:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gNFdb-0006u9-8a
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 06:16:44 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:37920)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gNFdZ-0006sK-EA
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 06:16:43 -0500
Received: by mail-oi1-x243.google.com with SMTP id a77so10492518oii.5
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 03:16:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181114101610.26854-1-cohuck@redhat.com>
References: <20181114101610.26854-1-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Nov 2018 11:16:16 +0000
Message-ID: <CAFEAcA9ABQyqCcne_33QF3H7qegqBUhLzOZvsib7jnPtzDNz5w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL for-3.1 0/1] bugfix for s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-s390x <qemu-s390x@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 14 November 2018 at 10:16, Cornelia Huck <cohuck@redhat.com> wrote:
> The following changes since commit 6ff144698935e8bdbc96d255cf49b1a7d54174ac:
>
>   Merge remote-tracking branch 'remotes/mdroth/tags/qga-pull-2018-11-12-tag' into staging (2018-11-13 12:32:30 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/cohuck/qemu tags/s390x-20181114
>
> for you to fetch changes up to b6e67ecc7b6e8938982ab94820c079f24845f623:
>
>   s390x/pci: properly fail if the zPCI device cannot be created (2018-11-13 16:46:55 +0100)
>
> ----------------------------------------------------------------
> Fix error handling during zpci device creation.
>
> ----------------------------------------------------------------
>
> David Hildenbrand (1):
>   s390x/pci: properly fail if the zPCI device cannot be created
>
>  hw/s390x/s390-pci-bus.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
>

Applied, thanks.

-- PMM
