Received: from eggs.gnu.org ([209.51.188.92]:52815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hGfuZ-0005yE-Ll
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 04:27:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hGfuY-0008B3-OT
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 04:27:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48200)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hGfuY-00088N-GN
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 04:27:18 -0400
Date: Wed, 17 Apr 2019 10:27:12 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190417082712.5g5nztxcctembe3z@sirius.home.kraxel.org>
References: <20190415154503.6758-1-berrange@redhat.com>
	<CAFEAcA-YpG71aGtTVMafShGyd9uM599Uy_8S3vvvnPzfiKMqnw@mail.gmail.com>
	<CAFEAcA-kywfUEZARqzH=obD1p3UsAcsNneK-X0BPpoFnV-QK0A@mail.gmail.com>
	<CAFEAcA_+sf3L5ChBDKEekKb5iTTQZu4mEfF7eiTL78oMDuR16A@mail.gmail.com>
	<CAFEAcA84DLEGQduvubsKP-2NrdNkzLcihL2WusZiHReupbF1PA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA84DLEGQduvubsKP-2NrdNkzLcihL2WusZiHReupbF1PA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH 0/3] usb-mtp: fix ObjectInfo request
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Bandan Das <bsd@redhat.com>, Thomas Huth <thuth@redhat.com>, Greg Kurz <groug@kaod.org>, Eric Blake <eblake@redhat.com>

On Tue, Apr 16, 2019 at 11:27:06PM +0100, Peter Maydell wrote:
> On Tue, 16 Apr 2019 at 20:33, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > On Tue, 16 Apr 2019 at 18:27, Peter Maydell <peter.maydell@linaro.org> wrote:
> > > Having thought a bit more I think I'd definitely like to apply
> > > just patch 2 for 4.0. Could people try to test that and confirm
> > > that it at least does not make the feature behave any worse?
> >
> > I've done a tentative merge test of patch 2, which is OK.
> > I'd like to push that either today or tomorrow (uk time):
> > objections?
> 
> ...now pushed.

Added the other two to the (4.1) usb queue.

thanks,
  Gerd
