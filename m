Received: from eggs.gnu.org ([2001:4830:134:3::10]:34612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1g81tK-0003yo-Mt
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 07:34:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1g81gG-0000cO-70
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 07:20:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36338)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1g81gE-0000WQ-Ub
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 07:20:31 -0400
Date: Thu, 4 Oct 2018 13:20:26 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181004132026.39c002ab@redhat.com>
In-Reply-To: <CAKPgXcHEVrW7a5WqcoPn6X8=-j07K3yvXo4sjYJKNonYd2asQw@mail.gmail.com>
References: <CAKPgXcHEVrW7a5WqcoPn6X8=-j07K3yvXo4sjYJKNonYd2asQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Hotplug handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sameeh Jubran <sameeh@daynix.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Wed, 3 Oct 2018 19:50:58 +0300
Sameeh Jubran <sameeh@daynix.com> wrote:

> Hi all,
> 
> I am trying to get the hotplug handler of a pci device in Qemu using
> "qdev_get_hotplug_handler" function. This function simply tries to get
> the hotplug handler from the parent bus. For some reason it's always
> null. Why it is not initialized?
> 
> Thanks!
> 

what's used qemu command line?
