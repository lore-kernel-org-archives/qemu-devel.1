Received: from eggs.gnu.org ([2001:4830:134:3::10]:47457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1ecQHB-0001Tz-0m
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 01:35:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1ecQH6-00060a-11
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 01:35:45 -0500
Received: from mail.ispras.ru ([83.149.199.45]:40992)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1ecQH5-0005xU-Ov
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 01:35:39 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20180111082452.27295.85707.stgit@pasha-VirtualBox>
	<ecc919de-5193-a83c-0e29-4b8d9bc8d7d7@redhat.com>
	<e0cbd675-7872-05c3-8c3e-214ef93e4552@redhat.com>
	<002201d38b9d$f0a248d0$d1e6da70$@ru>
	<357a23a7-2cac-a14d-f4b9-7f883b101ea7@redhat.com>
In-Reply-To: <357a23a7-2cac-a14d-f4b9-7f883b101ea7@redhat.com>
Date: Fri, 19 Jan 2018 09:35:41 +0300
Message-ID: <001e01d390ef$ba73c890$2f5b59b0$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] [RFC PATCH v3 00/30] replay additions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Paolo Bonzini' <pbonzini@redhat.com>, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, mst@redhat.com, jasowang@redhat.com, quintela@redhat.com, zuban32s@gmail.com, maria.klimushenkova@ispras.ru, kraxel@redhat.com, boost.lists@gmail.com, alex.bennee@linaro.org

> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
> On 12/01/2018 13:07, Pavel Dovgalyuk wrote:
> >
> > I can't build current version of qemu on Windows.
> > For the first time this happened when capstone was included into the build.
> 
> I've fixed it now.  

Is upstream version ok?
I still cannot build it on Windows.

Pavel Dovgalyuk
