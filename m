Received: from eggs.gnu.org ([2001:4830:134:3::10]:47545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fD5hX-000225-Cy
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 06:06:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fD5hS-00016N-Bg
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 06:06:31 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:45789)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fD5hS-000157-58
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 06:06:26 -0400
Received: by mail-wr0-f179.google.com with SMTP id p5-v6so7474124wre.12
	for <qemu-devel@nongnu.org>; Mon, 30 Apr 2018 03:06:26 -0700 (PDT)
References: <CAFEAcA-hha7jMSfPTdNEVKhuJr4nwAx4wKmEk5E9+j-JS4U14w@mail.gmail.com>
	<d50e3a40-d7f3-4c9b-e930-4c2f4d6c8a53@redhat.com>
	<CAFEAcA8wJuJ9464LadgjJOo-7ttdGYcfDQWALbkxBRJCr_knkg@mail.gmail.com>
	<062deb2a-35fc-319f-b159-3b58cbf910df@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <367ce2f5-a3b0-9e83-6c33-7924ae7aeb23@redhat.com>
Date: Mon, 30 Apr 2018 12:06:23 +0200
MIME-Version: 1.0
In-Reply-To: <062deb2a-35fc-319f-b159-3b58cbf910df@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] release retrospective, next release timing,
 numbering
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 27/04/2018 18:42, Thomas Huth wrote:
> On 27.04.2018 18:24, Peter Maydell wrote:
>> (In the utopian far future I'd like us to have just one QEMU
>> executable that could handle all architectures at once :-))
> 
> Yes, that would be great ... but that's really distant future, I guess.

Not _that_ impossible though.  Peter Crosthwaite had some initial
patches for multi-arch support.

Paolo
