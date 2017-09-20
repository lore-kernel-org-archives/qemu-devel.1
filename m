Received: from eggs.gnu.org ([2001:4830:134:3::10]:41162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dukFM-0001Ea-Gq
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 15:01:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dukFH-0007tz-NS
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 15:01:20 -0400
Received: from chuckie.co.uk ([82.165.15.123]:57699
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dukFH-0007lU-CS
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 15:01:15 -0400
References: <20170916010330.10435-1-jsnow@redhat.com>
	<CAFEAcA8un6eescSDzd+P+jqEGuGkuQXgfjm+1=CPOydg6WQSnQ@mail.gmail.com>
	<fb54f008-2913-3cd2-df95-41b1fcf3f2ee@redhat.com>
	<CAFEAcA9=syrPXD5cAq_EHWre_NniO1kZiWVAQXMDEnRuk=20ew@mail.gmail.com>
	<CAFEAcA9XgboiDD3SYsaJLRVMr=onckWU3VN-3ogd4DwH5fV3zw@mail.gmail.com>
	<824faf32-38bc-f3b9-cafb-f60cbd7fd8a7@ilande.co.uk>
	<93915fa3-cadb-7639-79bf-e23c39129352@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <b022d2a0-f56e-ba79-702e-f8bca0931bcc@ilande.co.uk>
Date: Wed, 20 Sep 2017 20:01:01 +0100
MIME-Version: 1.0
In-Reply-To: <93915fa3-cadb-7639-79bf-e23c39129352@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 00/11] Ide patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 20/09/17 18:55, John Snow wrote:

> Guh. From which distro does your GCC 4.7 hail?
> 
> Regardless, I suppose I will revert to Eric's workaround, though I like
> the way it reads an awful lot less.

Thanks John - it's just a standard Debian Wheezy installation on amd64.


ATB,

Mark.
