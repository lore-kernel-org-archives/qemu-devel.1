Received: from eggs.gnu.org ([2001:4830:134:3::10]:47426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1emhO3-0007Km-4E
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 09:53:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1emhO0-0008I3-3K
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 09:53:19 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35783)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1emhNz-0008Hd-TZ
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 09:53:16 -0500
Received: by mail-wr0-f196.google.com with SMTP id l43so3178893wrc.2
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 06:53:15 -0800 (PST)
References: <20180216121810.56ed961e.cohuck@redhat.com>
	<CAFEAcA8nRr6OgJ0OAgk6xL2dXQVrUMod5kMzPufykjVNj-yNug@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8b721785-5581-8936-2517-1fa00db3dabd@redhat.com>
Date: Fri, 16 Feb 2018 15:53:08 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8nRr6OgJ0OAgk6xL2dXQVrUMod5kMzPufykjVNj-yNug@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Process] QEMU submaintainers and pull requests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-s390x <qemu-s390x@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 16/02/2018 12:25, Peter Maydell wrote:
> On 16 February 2018 at 11:18, Cornelia Huck <cohuck@redhat.com> wrote:
> The block folks are already doing this, so we should just
> formalize what they're doing at the moment I guess. From my point
> of view as long as there's something I can easily filter
> in/out in the email body or subject so I don't get confused
> (and which doesn't require me to update my filters every time
> a new subsystem switches to using submaintainer pulls!)
> I don't mind about the rest of it. Maybe a subject line with
> 'PULL SUBSYSTEM s390x' (ditto block, etc etc) ?

What about just requiring you to be in the "To" or "Cc" fields?  That
works pretty well for Linux.

Paolo
