Received: from eggs.gnu.org ([2001:4830:134:3::10]:52928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dnQpQ-0003Aa-D3
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 10:52:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dnQpP-0002SW-8g
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 10:52:20 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:37866)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dnQpP-0002Rz-2G
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 10:52:19 -0400
Received: by mail-wm0-x22d.google.com with SMTP id u26so6078605wma.0
	for <qemu-devel@nongnu.org>; Thu, 31 Aug 2017 07:52:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170830180711.7974-1-eblake@redhat.com>
References: <20170830180711.7974-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 Aug 2017 15:51:57 +0100
Message-ID: <CAFEAcA9N6-p0NyqwVNdm9CURbnJ2m+w9NqO4maan71ewkBF7Zw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/11] NBD patches for 2.11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 30 August 2017 at 19:07, Eric Blake <eblake@redhat.com> wrote:
> The following changes since commit 1ab5eb4efb91a3d4569b0df6e824cc08ab4bd8ec:
>
>   Update version for v2.10.0 release (2017-08-30 17:02:54 +0100)
>
> are available in the git repository at:
>
>   git://repo.or.cz/qemu/ericb.git tags/pull-nbd-2017-08-30
>
> for you to fetch changes up to f35dff7e13b84d3fffe1103c2c69afd81df5e4f5:
>
>   block/nbd-client: refactor request send/receive (2017-08-30 13:00:38 -0500)
>
> ----------------------------------------------------------------
> nbd patches for 2017-08-30
>
> - Kashyap Chamarthy: qemu-iotests: Extend non-shared storage migration test (194)
> - Stefan Hajnaczi: 0/3 nbd-client: enter read_reply_co during init to avoid crash
> - Vladimir Sementsov-Ogievskiy: portions of 0/17 nbd client refactoring and fixing
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
