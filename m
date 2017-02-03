Received: from eggs.gnu.org ([2001:4830:134:3::10]:52612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cZke6-0003XO-9p
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 15:39:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cZke5-00018k-EW
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 15:39:50 -0500
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:34050)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1cZke5-00018g-9t
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 15:39:49 -0500
Received: by mail-oi0-x241.google.com with SMTP id w144so2284016oiw.1
	for <qemu-devel@nongnu.org>; Fri, 03 Feb 2017 12:39:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <9A2D4A25-ACA7-4A6C-9C0B-92248C8D30E4@akamai.com>
References: <20170125001041.14029-1-bobby.prani@gmail.com>
	<CAFEAcA-pdY6J_e035PGj5nxYrtN7V0SJMxMuaE0VECNJVKg5iQ@mail.gmail.com>
	<87y3xnp8u9.fsf@gmail.com>
	<9A2D4A25-ACA7-4A6C-9C0B-92248C8D30E4@akamai.com>
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Fri, 3 Feb 2017 15:39:18 -0500
Message-ID: <CAJhHMCC0qndX9jZY77+50T9RA7v33QC0zK11YNAvSSBqF6fEkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [RFC PATCH] linux-user: Add signal handling for
 x86_64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Wirth, Allan" <awirth@akamai.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "open list:All patches CC here" <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>

On Fri, Feb 3, 2017 at 11:10 AM, Wirth, Allan <awirth@akamai.com> wrote:

> The patch LGTM. :)

Thanks for checking the latest patch and for the initial work. I am
happy it did not get lost :)

-- 
Pranith
