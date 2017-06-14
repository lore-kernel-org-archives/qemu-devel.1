Received: from eggs.gnu.org ([2001:4830:134:3::10]:43362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dL6Mp-0004iX-3M
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 07:21:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dL6Mo-0006b0-DB
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 07:21:43 -0400
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:35380)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dL6Mo-0006ag-4K
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 07:21:42 -0400
Received: by mail-wr0-x235.google.com with SMTP id q97so185034657wrb.2
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 04:21:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170614082610.GB4370@redhat.com>
References: <20170607175419.13558-1-berrange@redhat.com>
	<CAFEAcA8eXe2+65KTYPHDpXgK2X3k=bdvVFdWfAAzP-OeWgL1gw@mail.gmail.com>
	<20170614082610.GB4370@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 14 Jun 2017 12:21:17 +0100
Message-ID: <CAFEAcA_K8zv-L1ZFHc_F01aXx1XHde09GbZwv+X8Yd7oy24miw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v1 0/5] Merge sockets 2017/06/07
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 14 June 2017 at 09:26, Daniel P. Berrange <berrange@redhat.com> wrote:
> Was this clang on OSX/FreeBSD too, or is that on Linux ? If the latter,
> what are the args to use with configure to exercise this scenario ?

Linux. For details of how to run the sanitizer, see
http://wiki.qemu.org/Testing#clang_UBSan

thanks
-- PMM
