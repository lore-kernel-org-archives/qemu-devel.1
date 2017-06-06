Received: from eggs.gnu.org ([2001:4830:134:3::10]:45461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dIHMg-0002Pj-W2
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 12:29:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dIHMg-0003QJ-9h
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 12:29:54 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:38538)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dIHMg-0003Q9-3T
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 12:29:54 -0400
Received: by mail-wm0-x234.google.com with SMTP id n195so104500131wmg.1
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 09:29:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <871sqxjd2k.fsf@dusky.pond.sub.org>
References: <20170606151757.32473-1-pbonzini@redhat.com>
	<871sqxjd2k.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Jun 2017 17:29:32 +0100
Message-ID: <CAFEAcA_92Uca62XUs51TQKyto1D=zGWYWC-htrw_nF3D4P3o6Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] docs: create interop/ subdirectory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Thomas Huth <thuth@redhat.com>

On 6 June 2017 at 17:28, Markus Armbruster <armbru@redhat.com> wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
>
>> This is for the future interoperability & management guide.  It includes
>> the QAPI docs, including the automatically generated ones, other socket
>> protocols (vhost-user, VNC), and the qcow2 file format.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>
> No objections to adding a bit more structure to docs/ this way.  Can't
> say I like the name interop/, though.  Oh well, it's not my bikeshed to
> paint :)

OTOH there is a certain amusement to be had from putting
some of our documentation under 'spin/' :-)

-- PMM
