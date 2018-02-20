Received: from eggs.gnu.org ([2001:4830:134:3::10]:34131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eo3SA-00047l-DG
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 03:39:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eo3S7-0001aC-8i
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 03:39:10 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54442 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eo3S7-0001Zu-3z
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 03:39:07 -0500
Date: Tue, 20 Feb 2018 09:38:57 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180220083857.5l33rci3iz35uaze@sirius.home.kraxel.org>
References: <CAG9FBFpFBrUrG0bRwjAo6xHYG4rnc0BT_ufLSa-HsO2WWgvKJw@mail.gmail.com>
	<3de4128f-7749-fc52-d5ec-5744b4e74301@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3de4128f-7749-fc52-d5ec-5744b4e74301@redhat.com>
Subject: Re: [Qemu-devel] qemu warnings and errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: James Barrett <xucaen@gmail.com>, qemu-devel@nongnu.org

  Hi,

> What version of QEMU?
> 
> > unknown keycodes `(unnamed)', please report to qemu-devel@nongnu.org
> 
> This part is the only part that urges you to report the error, but I
> don't know much about what's going on here.
> 
> Maybe Gerd knows?

We had lots of keymap/keycode changes recently, most likely this will be
fixed in 2.12, maybe it already is in 2.11.  So, when using something
older, try upgrading first (or just ignore it in case it happes to be a
key you don't need).

cheers,
  Gerd
